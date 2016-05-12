class Gallery extends React.Component {
  render () {
    return (
      <div id="gallery" className="carousel slide" data-ride="carousel">

        <div className="carousel-inner" role="listbox">
         {this.props.images.map((image, i) => {
            if(i === 0) {
              return <div key={i} className="carousel-item active"><img src={image} /></div>
            } else {
              return <div key={i} className="carousel-item"><img src={image} /></div>
            }
          })}
        </div>
        <a className="left carousel-control" href="#gallery" role="button" data-slide="prev">
          <span className="icon-prev" aria-hidden="true"></span>
          <span className="sr-only">Previous</span>
        </a>
        <a className="right carousel-control" href="#gallery" role="button" data-slide="next">
          <span className="icon-next" aria-hidden="true"></span>
          <span className="sr-only">Next</span>
        </a>
      </div>
    );
  }
}

Gallery.propTypes = {
  images: React.PropTypes.array
};
