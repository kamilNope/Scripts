function relative_path (path)
  return 'media' + '/' + path
end

function Link (element)
  element.target = relative_path(element.target)
  return element
end

function Image (element)
  element.src = relative_path(element.src)
  return element
end