import {
  Controller
} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['content', 'contentLength', 'title', 'titleLength'];

  updateContent() {
    this.contentLengthTarget.innerHTML = this.contentTarget.value.length
  }

  updateTitle() {
    this.titleLengthTarget.innerHTML = this.titleTarget.value.length
  }
}