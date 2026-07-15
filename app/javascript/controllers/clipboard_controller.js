import { Controller } from "@hotwired/stimulus"

class ClipboardController extends Controller {
  static values = { text: String }

  copy() {
    navigator.clipboard.writeText(this.textValue)
    this.element.innerHTML = "Copied to clipboard!"
  }
}

export default ClipboardController
