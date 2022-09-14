var doc = document.getElementById("content")
var footer = document.getElementsByTagName("footer")[0]
document.getElementsByTagName("body")[0].style.backgroundColor = "black"
doc.style.backgroundColor = "black"
doc.style.color = "white"
footer.style.backgroundColor = "black"
footer.style.color = "white"
traverseDoc(doc)
traverseDoc(footer)
function traverseDoc(element) {
    if(element.hasAttribute("class") || element.hasAttribute("style")) {
           element.style.color = "white"
       }
    element.style.backgroundColor = "black"
    for(var i = 0; i<element.children.length;i++) {
        traverseDoc(element.children[i])
    }
}
