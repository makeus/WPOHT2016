class Search extends React.Component {
  render () {
    return (
      <div>
        <div>Data: {this.props.data}</div>
      </div>
    );
  }
}

Search.propTypes = {
  data: React.PropTypes.object
};
