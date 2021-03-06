class Card extends React.Component {
  
  constructor () {
    super();
    this.state = {
      images: []
    }
  }
  render () {
    return (
      <div>
        <div className="row">
          <div className="col-sm-12 title">
            <h4>{this.props.price}</h4>
            <h4>{this.props.size}m<sup>2</sup></h4>
            <h4>{this.props.location ? this.props.location.address : 'Unknown address'} {this.props.location ? this.props.location.city : null}</h4>
            <button className="navbar-toggler hidden-sm-up" type="button" data-toggle="collapse" data-target="#nav">&#9776;</button>
            <a href={this.props.referrer} className="hidden-lg-down" type="button">&#x2715;</a>
          </div>
        </div>
        <div className="row">
          <div className="col-sm-12 gallery">
            <Gallery images={this.props.images} />
          </div>
        </div>
        <div className="row">
          <div className="col-sm-12 col-md-7">
            <div className="row">
            {this.props.coordinates ?
              <div className="map col-sm-12">
                <h2>Map</h2>
                <Map latitude={this.props.coordinates ? this.props.coordinates.latitude : null} longitude={this.props.coordinates ? this.props.coordinates.longitude : null} />
              </div>
            : null}
              <div className="features col-sm-12">
                <h2>{this.props.title}</h2>
                <p>{this.props.description}</p>
              </div>
            </div>
          </div>
          <div className="col-sm-12 col-md-5">
            <div className="row">
              <div className="seller col-sm-12">
                <Seller name={this.props.seller ? this.props.seller.name : null} company={this.props.seller ? this.props.seller.company : null} logo={this.props.seller ? this.props.seller.logo : null} image={this.props.seller ? this.props.seller.image : null} email={this.props.seller ? this.props.seller.email : null} />
              </div>
              <div className="contact col-sm-12">
                <Contact cardId={this.props.id} authenticityToken={this.props.authenticityToken} />
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }
}

Card.propTypes = {
  title: React.PropTypes.string,
  description: React.PropTypes.string,
  size: React.PropTypes.string,
  price: React.PropTypes.string,
  id: React.PropTypes.number,
  location: React.PropTypes.object,
  seller: React.PropTypes.object,
  coordinates: React.PropTypes.object,
  images: React.PropTypes.array,
  authenticityToken: React.PropTypes.string,
  referrer: React.PropTypes.string,
};
