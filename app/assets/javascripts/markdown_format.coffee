document.addEventListener 'turbolinks:load', ->
  elements = document.getElementsByClassName('markdown')
  for element in elements
    mdText = element.dataset.text
    element.innerHTML = SimpleMDE.prototype.markdown(mdText)
