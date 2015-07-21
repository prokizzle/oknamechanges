var TopFifteenChanges = React.createClass({
  render: function(){
    var topFifteen = this.props.changes.map(function(change){
      return (
          <li>
            <UsernameChange change={change} votes={false}/>
          </li>
      );
    });
  }
});