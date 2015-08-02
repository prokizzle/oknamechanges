var NameChangeFeed = React.createClass({
  getInitialState: function(){
    return {
      nameChanges: new FixedQueue(10, [this.props.firstChange]),
      likes: {},
      errors: {}
    };
  },
  componentDidMount: function(){
    this.getNameChange();
  },
  getNameChange: function(){
    var self = this;
    var changes = self.state.nameChanges;
    $.get('/api/random-name-change', function(data){
      changes.unshift(data);
      self.setState({
        nameChanges: changes
      });
      self.pollForNameChanges();
    });
  },
  pollForNameChanges: function(){
    var self = this;
    setTimeout(function(){
        self.getNameChange();
    }, 5000);
  },
  like: function(e){
    var id = e.currentTarget.id;
    var likes = this.state.likes;
    var errors = this.state.errors;
    var self = this;
    likes[id] = true;
    $.post('/api/upvote', {
      id: id
    }).done(function(){
      self.setState({likes: likes});
    }).fail( function(xhr, textStatus, errorThrown) {
      Alert.error("You must be logged in to vote!");
    });
  },
  likeButtonClass: function(id){
    if (this.state.likes[id]) {
      return 'fa fa-heart fa-3x';
    } else {
      return 'fa fa-heart-o fa-3x';
    }
  },
  render: function(){
    var classes;
    var self = this;
    if (this.state.nameChanges.length) {
      var feedItems = this.state.nameChanges.map(function(item, i){
        var newNames = '';
        for (var i = 0; i < item.new_names.length; i++) {
          newNames += '&nbsp;became&nbsp;<strong>' + item.new_names[i] + '</strong>'
        }
        if (i == 0) {
          classes = 'changeBox first';
        } else {
          classes = 'changeBox latter';
        }
        var fullString = '<strong>' + item.old_name + '</strong>' + newNames;
        return (
            <div className='row'>
              <div className={classes} id={item.id}>
                <div dangerouslySetInnerHTML={{__html: fullString}}></div>
              </div>
            </div>
        );
      });
    } else {
      var feedItems = <div className='loading'>Loading...</div>;
    };

    return (
      <div className='row'>
        {feedItems}
      </div>
    );
  }
});
