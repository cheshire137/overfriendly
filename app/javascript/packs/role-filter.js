import {on} from 'delegated-events'

on('change', '.js-role-filter', function(event) {
  const checkbox = event.target
  const role = checkbox.value
  const otherCheckboxes = document.querySelectorAll('.js-role-filter')

  for (const otherCheckbox of otherCheckboxes) {
    otherCheckbox.disabled = true
  }

  let url
  if (checkbox.checked) {
    url = checkbox.getAttribute('data-url-with')
  } else {
    url = checkbox.getAttribute('data-url-without')
  }

  window.location.href = url
})
