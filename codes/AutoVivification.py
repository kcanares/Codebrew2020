class AutoVivification(dict):
    """Implementation of perl's autovivification feature."""
    def __getitem__(self, item):
        try:
            return dict.__getitem__(self, item)
        except KeyError:
            value = self[item] = type(self)()
            return value


a = AutoVivification()

a[1][2][3] = 4
a[1][3][3] = 5
a[1][2]['test'] = 6

print(a)