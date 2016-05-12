class Map extends React.Component {
  render () {
    return (
        <div className="map-container" ref="map"></div>
    );
  }
  componentDidMount () {
    let map = new google.maps.Map(this.refs.map, {
      center: {lat: this.props.latitude, lng: this.props.longitude},
      zoom: 11,
      fullscreenControl: true,
      mapTypeControl: false,
      scaleControl: false,
      streetViewControl: false,
      rotateControl: false,
      zoomControl: false
    });
    let marker = new google.maps.Marker({
      position: {lat: this.props.latitude, lng: this.props.longitude},
      map: map
    });
  }
}

Map.propTypes = {
  latitude: React.PropTypes.number,
  longitude: React.PropTypes.number
};
