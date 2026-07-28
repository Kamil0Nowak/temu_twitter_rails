import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="comments"
export default class extends Controller {
  close() {
    const tweetId = this.element.dataset.commentsTweetIdValue

    this.element.innerHTML = `
      <a href="/tweets/${tweetId}/comments" class="text-blue-500 hover:underline">
        💬 Show comments
      </a>
    `
  }
}
