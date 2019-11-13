import axios from 'axios';
import humps from 'humps';
import { isUUID } from 'validator';

import auth from 'utils/authv2';
import { apiV2Endpoint } from 'utils/env';

const decamelizeKeys = data => data && humps.decamelizeKeys(data);

const camelizeKeys = data => (
  data && humps.camelizeKeys(data, {
    process: (key, convert, options) => {
      if (isUUID(key)) {
        return key;
      } else {
        return (convert(key.toLowerCase(), options));
      }
    },
  })
);

const axiosConfig = {
  baseURL: apiV2Endpoint,
  headers: {
    'Content-Type': 'application/json',
  },
  transformRequest: [
    ...axios.defaults.transformRequest,
    data => data && JSON.stringify(decamelizeKeys(JSON.parse(data))),
  ],
  transformResponse: [
    ...axios.defaults.transformResponse,
    data => camelizeKeys(data),
  ],
};

const axiosInstance = axios.create(axiosConfig);

export const _onRequest = (config) => {
  const newConfig = {
    ...config,
    headers: {
      authorization: `Bearer ${auth.getToken()}`,
      ...config.headers,
    },
  };

  return newConfig;
};

export const _onReject = (error) => {
  if (error.response && error.response.status === 401) {
    if (error.response.data.error === 'Wrong User/Password') {
      throw new Error(error.response.data.error);
    }
    if (error.response.data.error !== 'Wrong User/Password') {
      auth.removeToken();
      window.location = '/login';
    }
  }
  if (error.response && error.response.status === 400) {
    throw new Error(error.response.data.error);
  }
  throw error;
};

axiosInstance.interceptors.request.use(
  _onRequest,
);
axiosInstance.interceptors.response.use(
  r => r,
  _onReject,
);

export default axiosInstance;
