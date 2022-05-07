var favoriteId = '<%= @favorite.id%>'
function toggleLikeButton(favoriteId, innerHTML) {
    let likeButton = document.querySelector(`.like-icon[data-id='${favoriteId}']`)
    likeButton.classList.toggle('red');
}toggleLikeButton(favoriteId);