<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style>
    /* CSS cho bong bóng chat */
    .zalo-chat-bubble {
        position: fixed;
        bottom: 30px;
        right: 30px;
        width: 60px;
        height: 60px;
        background: linear-gradient(135deg, #00A8FF, #007BFF); /* Gradient màu Zalo */
        border-radius: 50%;
        display: flex;
        justify-content: center;
        align-items: center;
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        cursor: pointer;
        transition: all 0.3s ease;
        z-index: 1000;
        animation: float 3s ease-in-out infinite; /* Hiệu ứng nổi */
    }

    .zalo-chat-bubble:hover {
        transform: scale(1.15) translateY(-5px); /* Phóng to và nâng lên khi hover */
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.25);
    }

    .zalo-chat-bubble img {
        width: 40px; /* Điều chỉnh kích thước để logo vừa với bong bóng */
        height: 40px;
        filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.1)); /* Bóng nhẹ cho icon */
    }

    /* Tooltip */
    .zalo-chat-bubble .tooltip {
        visibility: hidden;
        width: 140px;
        background-color: #222;
        color: #fff;
        text-align: center;
        border-radius: 8px;
        padding: 8px 10px;
        position: absolute;
        bottom: 75px;
        right: -40px; /* Căn giữa tooltip so với bong bóng */
        font-size: 14px;
        font-family: Arial, sans-serif;
        opacity: 0;
        transition: opacity 0.3s ease, transform 0.3s ease;
        transform: translateY(10px); /* Hiệu ứng trượt lên */
    }

    .zalo-chat-bubble .tooltip::after {
        content: '';
        position: absolute;
        top: 100%;
        left: 50%;
        margin-left: -6px;
        border-width: 6px;
        border-style: solid;
        border-color: #222 transparent transparent transparent; /* Mũi tên chỉ xuống */
    }

    .zalo-chat-bubble:hover .tooltip {
        visibility: visible;
        opacity: 1;
        transform: translateY(0); /* Trượt lên khi hiển thị */
    }

    /* Hiệu ứng nổi */
    @keyframes float {
        0%, 100% {
            transform: translateY(0);
        }
        50% {
            transform: translateY(-8px);
        }
    }
</style>

<!-- Bong bóng chat Zalo -->
<a href="https://zalo.me/0123456789" target="_blank" class="zalo-chat-bubble">
    <img src="assets/img/zalo-icon.png" alt="Zalo Icon"> <!-- Thay bằng đường dẫn logo của bạn -->
    <span class="tooltip">Chat with us now!</span>
</a>