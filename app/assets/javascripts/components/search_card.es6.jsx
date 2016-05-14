class SearchCard extends React.Component {
  render () {
    return (
      <a href={'/cards/' + this.props.card.id} className="search-card col-lg-4">
        <div className="search-card-image" style={{backgroundImage: 'url(' + this.props.card.image + ')'}} />
        <div className="search-card-info">
          <div className="search-card-info-price-size">
            <h4>{this.props.card.price}</h4>
            <h4>{this.props.card.size} m<sup>2</sup></h4>
          </div>
          <p>{this.props.card.address}</p>
          <div className="search-card-features">
          {this.props.card.features ? Object.keys(this.props.card.features).map((feature) => {
            if(this.props.card.features[feature]) 
              return <i key={feature} className={'icon-' + feature} />
            return null;
          }) : null}
          </div>
        </div>
        <p className="search-card-readmore">Read more</p>
      </a>
    );
  }
}

SearchCard.propTypes = {
  card: React.PropTypes.object
};
