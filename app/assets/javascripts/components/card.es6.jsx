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
          <div className="col-sm-12 gallery">
            <Gallery images={this.props.images} />
          </div>
        </div>
        <div className="row">
          <div className="col-sm-12 col-md-7">
            <div className="row">
              <div className="map col-sm-12">
                <h2>Map</h2>
                <Map latitude={this.props.coordinates.latitude} longitude={this.props.coordinates.longitude} />
              </div>
              <div className="features col-sm-12">
                <h2>{this.props.title}</h2>
                <p>{this.props.description}</p>
              </div>
            </div>
          </div>
          <div className="col-sm-12 col-md-5">
            <div className="row">
              <div className="seller col-sm-12">
                <Seller name={this.props.seller.name} company={this.props.seller.company} logo={this.props.seller.logo} image={this.props.seller.image} email={this.props.seller.email} />
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
  card: React.PropTypes.object
};
