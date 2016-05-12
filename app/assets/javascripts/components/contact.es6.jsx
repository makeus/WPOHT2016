class Contact extends React.Component {
  render () {
    return (
      <form action="/contacts" acceptCharset="UTF-8" method="post">
        <input type="hidden" defaultValue={this.props.cardId} name="contact[card_id]" />
        <input type="hidden" name="authenticity_token" defaultValue={this.props.authenticityToken} />
        <fieldset className="form-group">
          <label htmlFor="name">Name</label>
          <input type="text" className="form-control" name="contact[name]" id="name" />
        </fieldset>
        <fieldset className="form-group">
          <label htmlFor="email">E-mail</label>
          <input type="email" className="form-control" name="contact[email]" id="email" />
        </fieldset>
        <fieldset className="form-group">
          <label htmlFor="phone">Phone number</label>
          <input type="tel" className="form-control" name="contact[phone]" id="phone" />
        </fieldset>
        <fieldset className="form-group">
          <label htmlFor="message">Message</label>
          <textarea className="form-control" name="contact[message]" id="message" rows="3" />
        </fieldset>
        <button type="submit" className="btn btn-primary">Send</button>
      </form>
    );
  }
}

Contact.propTypes = {
  cardId: React.PropTypes.number,
  authenticityToken: React.PropTypes.string
};
