import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cart"
export default class extends Controller {
  static targets = ["cartBox"];
  // connect() {
  //   console.log("HELLOOOOOO");
  // }

  revealCart() {
    console.log('Hi there');
    this.cartBoxTarget.classList.remove('hidden');
  }

  hideCart() {
    console.log('Bye there');
    this.cartBoxTarget.classList.add('hidden');
  }
}
