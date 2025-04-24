<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bus Ticketing System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        body {
            background-color: #f4f4f4;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #0056b3;
            padding: 15px 30px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .logo-container {
            display: flex;
            align-items: center;
        }

        .logo {
            width: 40px;
            height: 40px;
            margin-right: 10px;
            background-color: #fff;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .logo-icon {
            color: #0056b3;
            font-size: 24px;
            font-weight: bold;
        }

        .brand-name {
            color: white;
            font-size: 24px;
            font-weight: bold;
        }

        .nav-links {
            display: flex;
            gap: 20px;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-size: 16px;
            padding: 8px 15px;
            transition: background-color 0.3s;
            border-radius: 5px;
        }

        .nav-links a:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }

        .hero {
            background: linear-gradient(rgba(0, 86, 179, 0.7), rgba(0, 86, 179, 0.7));

            background-size: cover;
            height: 400px;
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
            text-align: center;
            padding: 20px;
        }

        .hero-content h1 {
            font-size: 42px;
            margin-bottom: 20px;
        }

        .hero-content p {
            font-size: 18px;
            margin-bottom: 30px;
            max-width: 700px;
        }

        .btn {
            background-color: #ff6b00;
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
            text-decoration: none;
            display: inline-block;
        }

        .btn:hover {
            background-color: #e05d00;
        }

        .features {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            padding: 50px 20px;
            background-color: white;
        }

        .feature-card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 25px;
            margin: 15px;
            width: 300px;
            text-align: center;
        }

        .feature-icon {
            font-size: 36px;
            color: #0056b3;
            margin-bottom: 15px;
        }

        .feature-card h3 {
            margin-bottom: 15px;
            color: #333;
        }

        .feature-card p {
            color: #666;
            line-height: 1.6;
        }

        footer {
            background-color: #333;
            color: white;
            text-align: center;
            padding: 20px;
            margin-top: 30px;
        }
    </style>
</head>

<body>
<!-- Navigation Bar -->
<nav class="navbar">
    <div class="logo-container">
        <div class="logo">
            <span class="logo-icon">B</span>
        </div>
        <span class="brand-name">BusTickets</span>
    </div>

    <div class="nav-links">
        <a href="home">Home</a>
        <a href="register">Register</a>
        <!-- Updated link -->
        <a href="login">Login</a> <!-- Uses the servlet's URL -->
    </div>
</nav>

<!-- Hero Section -->
<section class="hero">
    <div class="hero-content">
        <h1>Travel Made Easy</h1>
        <p>Book your bus tickets online with just a few clicks.
            Experience hassle-free travel planning with our user-friendly
            booking system.</p>
        <a href="login" class="btn">Book Now</a>
    </div>
</section>

<!-- Features Section -->
<section class="features">
    <div class="feature-card">
        <div class="feature-icon">🎫</div>
        <h3>Easy Booking</h3>
        <p>Book your tickets in minutes with our simple and intuitive
            booking process.</p>
    </div>

    <div class="feature-card">
        <div class="feature-icon">💰</div>
        <h3>Best Prices</h3>
        <p>Get the best deals on bus tickets with our competitive
            pricing.</p>
    </div>

    <div class="feature-card">
        <div class="feature-icon">🚌</div>
        <h3>Wide Network</h3>
        <p>Access hundreds of routes and destinations across the country.</p>
    </div>
</section>

<!-- Footer -->
<footer>
    <p>&copy; 2025 BusTickets. All rights reserved.</p>
</footer>
</body>

</html>