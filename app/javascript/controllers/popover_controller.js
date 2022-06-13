import { Controller } from "@hotwired/stimulus"
import * as bootstrap from "bootstrap"

// Connects to data-controller="popover"
export default class extends Controller {
  connect() {
    console.log("hello from popover controller")
    let popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))  
    let popoverList = popoverTriggerList.map(function (popoverTriggerEl) {  
    return new bootstrap.Popover(popoverTriggerEl)  
    })  
  }
}
