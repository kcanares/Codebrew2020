import React from 'react';
import APIService from '../libs/apiService';

class Home extends React.Component {
  state = {
    serverMessage: null
  }

  componentDidMount() {
    APIService.getServerResponse()
      .then(res => {
        this.setState({ serverMessage: res.data.message });
      });
  }

  render() {
    const { serverMessage } = this.state;

    return (
      <div>
        <h1>Home Page</h1>
        <p>Server Response: { serverMessage }</p>
      </div>
    )
  }
}

export default Home;