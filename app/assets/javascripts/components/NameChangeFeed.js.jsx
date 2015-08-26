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
  render: function(){
    var classes;
    var self = this;
    if (this.state.nameChanges.length) {
      var feedItems = this.state.nameChanges.map(function(item, i){
        var newNames = '';
        for (var j = 0; j < item.new_names.length; j++) {
          newNames += ' became ' + item.new_names[j]
        }
        if (i == 0) {
          classes = 'changeBox first';
        } else {
          classes = 'changeBox latter';
        }
        var fullString = item.old_name + newNames;
        if (item.match) {
          var gender = item['match']['gender'].;
          var location = item['match']['state'];
          var age = item['match']['age'];
        }
        return (
            <div className='row' key={i}>
              <div className='columns small-12 medium-12 large-12'>
                <p className={classes} id='react-div'>{fullString}
                  {if (item.match) {
                      return (<span>{age}/{gender}/{location}</span>)
                  }}
                </p>
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
