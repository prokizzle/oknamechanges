var OldName = React.createClass({
  render: function(){
    return (
      <span className='oldName'>{this.props.item.old_name}</span>
    );
  }
});