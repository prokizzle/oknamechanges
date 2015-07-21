var NewNames = React.createClass({
  render: function(){
    var newNames = this.props.item.new_names.map(function(name){
      return (
        <span>
          <span className='became'>became</span>
          <span className='newName'>{name}</span>
        </span>
      );
    });

    return (
      <span>
        {newNames}
      </span>
    );
  }
});