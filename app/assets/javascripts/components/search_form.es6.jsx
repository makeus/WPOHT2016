class SearchForm extends React.Component {

  componentDidMount () {
    $(this.refs.form).on("submit", function(e) {
      Turbolinks.visit(this.action+(this.action.indexOf('?') == -1 ? '?' : '&')+$(this).find(":input").filter((index, element) => {return $(element).val() != ""; }).serialize());
      return false;
    });
  }

  render () {
    return (
      <div ref="searchForm">
        <div className="row">
          <div className="col-sm-12 title navbar-title">
            <h4><i className="icon-search" /> Search</h4>
            <button className="navbar-toggler hidden-md-up" type="button" data-toggle="collapse" data-target="#nav">✕</button>
          </div>
        </div>
        <div className="navigation">
          <form ref="form" method="get" action="/cards">
            <h3>Country</h3>
            <input type="hidden" name="limit" defaultValue="12" />
            <input type="hidden" name="offset" defaultValue="0" />
            <div className="row">
              <div className="col-xs-6">
                <label className="c-input c-checkbox">
                  <input name="location[]" defaultValue="FI" type="checkbox" />
                  <span className="c-indicator" />
                  Finland
                </label>
              </div>
              <div className="col-xs-6">
                <label className="c-input c-checkbox">
                  <input name="location[]" defaultValue="SE" type="checkbox" />
                  <span className="c-indicator" />
                  Sweden
                </label>
              </div>
              <div className="col-xs-6">
                <label className="c-input c-checkbox">
                  <input name="location[]" defaultValue="NO" type="checkbox" />
                  <span className="c-indicator" />
                  Norway
                </label>
              </div>
              <div className="col-xs-6">
                <label className="c-input c-checkbox">
                  <input name="location[]" defaultValue="EE" type="checkbox" />
                  <span className="c-indicator" />
                  Estonia
                </label>
              </div>
              <div className="col-xs-6">
                <label className="c-input c-checkbox">
                  <input name="location[]" defaultValue="ES" type="checkbox" />
                  <span className="c-indicator" />
                  Spain
                </label>
              </div>
              <div className="col-xs-6">
                <label className="c-input c-checkbox">
                  <input name="location[]" defaultValue="FR" type="checkbox" />
                  <span className="c-indicator" />
                  France
                </label>
              </div>
            </div>
            <h3>Minimum price</h3>
            <div className="price-input">
              <input name="price[min]" className="form-control" />
            </div>
            <h3>Features</h3>
            <div className="row features-row">
              <div className="col-xs-6">
                <label>
                  <input name="features[]" defaultValue="sauna" type="checkbox" />
                  <div className="feature-score">
                    <div>
                      <i className="icon-sauna" />
                      <h4>Sauna</h4>
                    </div>
                  </div>
                </label>
              </div>
              <div className="col-xs-6">
                <label>
                  <input name="features[]" defaultValue="shore" type="checkbox" />
                  <div className="feature-score">
                    <div>
                      <i className="icon-sea" />
                      <h4>Shore</h4>
                    </div>
                  </div>
                </label>
              </div>
            </div>
            <div className="row features-row">
              <div className="col-xs-6">
                <label>
                  <input name="features[]" defaultValue="pool" type="checkbox" />
                  <div className="feature-score">
                    <div>
                      <i className="icon-pool" />
                      <h4>Pool</h4>
                    </div>
                  </div>
                </label>
              </div>
              <div className="col-xs-6">
                <label>
                  <input name="features[]" defaultValue="garage" type="checkbox" />
                  <div className="feature-score">
                    <div>
                      <i className="icon-car" />
                      <h4>Garage</h4>
                    </div>
                  </div>
                </label>
              </div>
            </div>
            <input type="submit" className="btn btn-primary col-xs-12" defaultValue="Search" />
          </form>
        </div>
      </div>
    );
  }
}
