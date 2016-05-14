class SearchResult extends React.Component {
  render () {
    return (
       <div>
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
      </div>
    );
  }
}

SearchResult.propTypes = {
  cards: React.PropTypes.array,
  total: React.PropTypes.number
};
