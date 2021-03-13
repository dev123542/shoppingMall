// myswiper.js

var swiper = new Swiper('.swiper-container', {
    speed: 800,
    slidesPerView: 1,
    spaceBetween: 0,
    loop: true,
    grabCursor:	false,
    mousewheel: false,
    simulateTouch: true,
    autoplay: {
        delay: 3600,
        disableOnInteraction: false,
    },
    keyboard: {
        enabled: true,
    },
    pagination: {
        el: '.swiper-pagination',
        clickable: true,
    },
    navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
    },
});

