var TopFifteenChanges = React.createClass({
  render: function(){

    var topFifteen = this.props.changes.map(function(change){
      return (
          <li>
            <UsernameChange changes={this.props.changes} votes={false}/>
          </li>
      );
    });
  }
});