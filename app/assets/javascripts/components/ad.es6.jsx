class Ad extends React.Component {
  render () {
    return (
      <div>
        <div>Ad Data: {this.props.adData.a}</div>
      </div>
    );
  }
}

Ad.propTypes = {
  adData: React.PropTypes.object
};
