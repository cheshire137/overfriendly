import {on} from 'delegated-events'
import SelectorObserver from 'selector-observer'

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

const getParams = query => {
  if (!query) {
    return { }
  }

  return (/^[?#]/.test(query) ? query.slice(1) : query).split('&').
    reduce((params, param) => {
      const [ key, value ] = param.split('=')
      params[key] = value ? decodeURIComponent(value.replace(/\+/g, ' ')) : ''
      return params
    }, { })
}

const observer = new SelectorObserver(document, '.js-player-summary', function() {
  const url = window.location.href
  const queryIndex = url.indexOf('?')
  let showPlayer = false

  if (queryIndex < 0) {
    showPlayer = true
  } else {
    const query = url.slice(queryIndex + 1)
    const params = getParams(query)
    const omittedRoles = (params.omit_role || '').split(',')
    const playerRoles = this.getAttribute('data-roles').split(',')
    const playerRolesIncluded = playerRoles.map(role => omittedRoles.indexOf(role) < 0)
    for (const isRoleIncluded of playerRolesIncluded) {
      if (isRoleIncluded) {
        showPlayer = true
        break
      }
    }
  }

  if (showPlayer) {
    const container = this.closest('.js-player-container')
    container.classList.remove('d-none')
  }
})
observer.observe()
