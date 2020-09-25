import re

import scrapy
from scrapy.http import Request
import html2text


def convert_str_to_minutes(string):
    if 'hr' in string and 'mins' in string:
        hour = int(string[0:string.find('hr')-1])
        minute = int(string[string.find('and')+4:string.find('mins')-1])
        minute = minute + 60 * hour
    elif 'hr' in string and 'mins' not in string:
        hour = int(string[0:string.find('hr') - 1])
        minute = 60 * hour
    else:
        minute = int(string[0:string.find('mins')-1])
    return minute


class RecipeSpider(scrapy.Spider):
    name = "recipe"

    def __init__(self, start_url, **kwargs):
        self.page_idx = 1
        self.start_urls = [start_url]
        super().__init__(**kwargs)

    def parse(self, response):
        article_selectors = response.css(".standard-card-new__article-title")
        if article_selectors:
            for selector in article_selectors:
                link = selector.xpath("@href").extract_first()
                if link:
                    yield Request(url=link, callback=self.parse_article)
        else:
            return

        # self.page_index += 1
        # if self.page_index > 100:
        #     return
        # yield Request(
        #         url=self.BASE_URL+str(self.page_index),
        #         callback=self.parse,
        #         dont_filter=True
        # )

    def parse_article(self, response):
        recipe = {
            'nutrition': {},
            'ingredients': [],
            'steps': [],
            'keywords': []
        }

        recipe['name'] = response.css("h1::text").extract()[0]
        recipe['image_url'] = response.css('.masthead__image div div picture img::attr(src)').extract_first()

        time_selector = response.css(".icon-with-text__children ul li time::text")
        recipe['prep_time'] = convert_str_to_minutes(time_selector.extract()[0])
        recipe['cook_time'] = convert_str_to_minutes(time_selector.extract()[1])

        ingredient_selector = response.css('.pb-xxs')
        for selector in ingredient_selector:
            quantity_str = selector.css('::text').extract()[0].strip()
            try:
                ingredient = selector.css('.link::text').extract()[0].replace(',', '')
            except:
                ingredient = selector.css('::text').extract()[1].replace(',', '')

            try:
                quantity = re.findall(r"\d+", quantity_str)[0]
                measurement_re = re.findall(r"tsp|tbsp|ml|g|stalks", quantity_str)
                measurement = measurement_re[0] if measurement_re else 'quantity'

                item = {
                    'name': ingredient,
                    'quantity': int(quantity),
                    'measurement': measurement
                }
                recipe['ingredients'].append(item)
                recipe['keywords'].append(ingredient)
            except:
                continue

        nutrition_selector = response.css(".key-value-blocks__item")
        for selector in nutrition_selector:
            key = selector.css('.key-value-blocks__key::text').extract()[0]
            value = selector.css('.key-value-blocks__value::text').extract()[0]
            recipe['nutrition'][key] = float(value)

        converter = html2text.HTML2Text()
        converter.ignore_links = True
        converter.ignore_anchors = True
        converter.ignore_images = True
        converter.ignore_emphasis = True

        step_selector = response.css(".grouped-list ul li .editor-content p").extract()
        for selector in step_selector:
            text = converter.handle(selector)
            if text.startswith('\n\n'):
                text = text[2:]
            if text.endswith('\n\n'):
                text = text[:-2]
            text = text.replace('\n', ' ')
            recipe['steps'].append(text)

        yield recipe
