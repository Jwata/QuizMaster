document.addEventListener 'turbolinks:load', ->
  textArea = document.getElementById('mde')
  return unless textArea
  mde = new SimpleMDE(
    autofocus: true
    element: textArea
  )
  previewArea = document.getElementById('mde-preview')
  previewArea.innerHTML = mde.markdown(mde.value())
  mde.codemirror.on 'change', ->
    previewArea.innerHTML = mde.markdown(mde.value())
