var NameChange = React.createClass({
  style: function(){
    if (index == 0) {
      return {
        display: 'flex',
        justifyContent: 'center',
        alignItems: 'center',
        fontSize: '150%',
        wordBreak: 'normal',
        wordWrap: 'break-word'
      };
    } else {
      return {
        display: 'flex',
        justifyContent: 'center',
        alignItems: 'center'
      };
    }
  },
  render: function(){
    var item = this.props.item;
    return (
      <div className='columns large-10 medium-10 small-10 panel' id={item.id} style={this.style()}>
        <OldName item={item} /><NewNames item={item} />
      </div>
    );
  }
});