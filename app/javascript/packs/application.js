document.addEventListener("turbolinks:load", () => {
    const toggleButton = document.getElementById("togglePostForm");
    const postForm = document.getElementById("newPostForm");
  
    if (toggleButton && postForm) {
      toggleButton.addEventListener("click", () => {
        if (postForm.style.display === "none") {
          postForm.style.display = "block";
        } else {
          postForm.style.display = "none";
        }
      });
    }
  });
  