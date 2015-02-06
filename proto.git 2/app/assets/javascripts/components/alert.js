$(function(){
  var Alert = {
    alertElement: $('#alert')
  }
  Alert.show = function (message) {
    this.alertElement.find(".container").text(message)
    this.alertElement.slideDown('fast')
    this.timeout = setTimeout(_.bind(this.hide, this), 3000)
  }
  Alert.hide = function () {
    this.alertElement.slideUp('fast')
  }
  $(document).ajaxError(function(event, xhr, settings, error){
    try {
      var data = JSON.parse(xhr.responseText)
      Alert.show(data.errors[0])
    } catch (err) {
      console.log(err)
    }
  })
})
