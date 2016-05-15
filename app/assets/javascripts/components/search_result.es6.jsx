class SearchResult extends React.Component {


  render () {

    return (
       <div className="search-result">
        <div className="row">
          <div className="col-sm-12 title">
            <h4>You got {this.props.total} results</h4>
            <button className="navbar-toggler hidden-sm-up" type="button" data-toggle="collapse" data-target="#nav">&#9776;</button>
          </div>
        </div>

        <div className="row search-cards">
          {this.props.cards.map((card, i) => {
            return <SearchCard key={card.id} card={card}></SearchCard>
          })}
        </div>
        <div className="search-result-pagination">
          <a className="btn btn-primary" href={this.state ? this.state.prevUrl : null} ><i className="icon-prev" /> Prev</a>
          <a className="btn btn-primary" href={this.state ? this.state.nextUrl : null} >Next <i className="icon-next" /></a>
        </div>
      </div>
    );
  }

  componentDidMount () {
    var url = window.location.href;
    let curLimit = location.search.split('limit=')[1]
    let curOffset = location.search.split('offset=')[1]
    let nextUrl, prevUrl;

    if(!curLimit || !curOffset) {
        nextUrl = url += (url.split('?')[1] ? '&':'?') + 'offset=' + 12 + '&limit=12';
        prevUrl = undefined;
    } else {
        curLimit = parseInt(curLimit);
        curOffset = parseInt(curOffset);

        if(curLimit * 2 + curOffset > this.props.total) {
            nextUrl = undefined;
        } else { 
            let newOffset = curOffset + curLimit;
            nextUrl = url.replace(/(offset=).*?(&)/,'$1' + newOffset + '$2');
        }

        if(curOffset - curLimit < 0) {
            prevUrl = undefined;
        } else {
            let newOffset = curOffset - curLimit;
            prevUrl = url.replace(/(offset=).*?(&)/,'$1' + newOffset + '$2');
        }
    }
    this.setState({nextUrl: nextUrl, prevUrl: prevUrl});
  }
}

SearchResult.propTypes = {
  cards: React.PropTypes.array,
  total: React.PropTypes.number
};
