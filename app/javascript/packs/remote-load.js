import SelectorObserver from 'selector-observer'
import Fetcher from './fetcher.js'

const observer = new SelectorObserver(document, '.js-remote-load', function() {
  const url = this.getAttribute('data-url')
  if (url.indexOf('/') !== 0) {
    return
  }

  const tokenMeta = document.querySelector('meta[name="csrf-token"]')
  const token = tokenMeta.content
  const headers = { 'X-CSRF-TOKEN': token }
  const fetcher = new Fetcher()
  fetcher.get(url, headers).then(html => this.innerHTML = html)
})
observer.observe()
