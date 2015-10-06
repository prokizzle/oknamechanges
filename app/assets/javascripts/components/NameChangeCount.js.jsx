var NameChangeCount = React.createClass({
  getInitialState: function (){
    return {totalChanges: this.props.totalChanges}
  },
  componentDidMount: function(){
    this.getTotalChanges();
  },
  getTotalChanges: function(){
    var self = this;
    $.get('/api/total-changes', function(data){
      self.setState({
        totalChanges: data.total_changes
      });
      setTimeout(this.getTotalChanges, 5000);
    });
  },
  render: function (){
    return (
      <span class='NameChangeCount'>
        {this.state.totalChanges}
      </span>
    );
  }
});