class Seller extends React.Component {
  render () {
    return (
      <div>
        <div className="row seller-images">
          <div className={this.props.image ? "col-xs-6 seller-image" : "hidden"} style={{backgroundImage: 'url(' + this.props.image + ')'}}>
          </div>
          <div className="col-xs-6">
            <img src={this.props.logo} />
          </div>
        </div>
        <div className="seller-text">
          <h2>{this.props.name}</h2>
          <h3>{this.props.company}</h3>
        </div>
      </div>
    );
  }
}

Seller.propTypes = {
  name: React.PropTypes.string,
  company: React.PropTypes.string,
  email: React.PropTypes.string,
  logo: React.PropTypes.string,
  image: React.PropTypes.string
};
