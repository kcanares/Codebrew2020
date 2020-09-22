import { get, post, put } from './api';

const APIService = {
  getServerResponse: () => {
    return get(`/api/`);
  }
}

export default APIService;