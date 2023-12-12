<a name="readme-top"></a>

<img src="./assets/readme/mockup_app.png" alt="drawing"/>

<br />
<div align="center">
  <a href="https://github.com/yagoquesada/brainy">
    <img src="assets/readme/dibujo_logo_trans.png" alt="Logo" width="180" height="180">
  </a>

<h3 align="center">Brainy App</h3>

  <p align="center">
    Introducing *Brainy*, the innovative app powered by GPT-4 for intelligent Chatbot conversations and DALL-E 2 for stunning Image Generation.
    <br />
    <a href="https://github.com/github_username/repo_name"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/github_username/repo_name">View Demo</a>
    ·
    <a href="https://github.com/github_username/repo_name/issues">Report Bug</a>
    ·
    <a href="https://github.com/github_username/repo_name/issues">Request Feature</a>
  </p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">ScreenShots</a></li>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>

## 📸 ScreenShots
<p align="center">
  <img src="./assets/readme/landing_screen.png" alt="drawing" width="300"/> <img src="./assets/readme/home_screen_full.png" alt="drawing" width="300"/>
</p>

<p align="center">
  <img src="./assets/readme/chat_screen_full.png" alt="drawing" width="300"/> <img src="./assets/readme/image_generated_screen.png" alt="drawing" width="300"/>
</p>

## 📄 Description
Brainy is an innovative application that seamlessly integrates two powerful features:

- **Chatbot using GPT-4:**
  Brainy harnesses the advanced GPT-4 model through the OpenAI API to provide an interactive and intelligent chatbot experience. Engage in natural and dynamic conversations with Brainy.

- **Image Generation:**
  Alongside its exceptional chatbot capabilities, Brainy incorporates an image generator that taps into the OpenAI API. Generate stunning and diverse images based on various inputs, adding an artistic touch to your interactions.

## ✅ Getting Started 

### Prerequisites

Software that users need to have installed before they can use your project.

- Flutter: [Installation Guide](https://flutter.dev/docs/get-started/install)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yagoquesada/brainy.git
2. Change to the project directory
   ```bash
   cd your-project
3. Install dependencies
   ```bash
   flutter pub get
   
## Usage

Create a .env file in the project directory. Inside paste the following code:

  ```bash
  OPENAI_API_KEY = YOUR_API_KEY
  OPENAI_BASE_URL = https://api.openai.com/v1
  OPENAI_MODEL = gpt-4
  ```

> [!IMPORTANT]
> Change *YOUR_API_KEY* for your own OpenAI API key. Follow the instructions below to get your key and understand how to work with the OpenAI API.
> 
> [Quickstart Tutorial - OpenAI API](https://platform.openai.com/docs/quickstart?context=python)

> [!WARNING]
> OpenAI has different tiers, as your usage of the OpenAI API and your spend on the API goes up, they automatically graduate you to the next usage tier. So depending on the tier you might have errors when reaching the rate limit. For more information about rate limits and OpenAI tiers, read the following documentation:
> 
> [Rate limits - OpenAI API](https://platform.openai.com/docs/guides/rate-limits)  

Then you are ready to run it!
  ```bash
  flutter run
  ```

## ⚙️ Features
- Chatbot using GPT-4:
  - Utilizes GPT-4 model through OpenAI API to provide conversational capabilities.
- Image Generation:
  - Utilizes OpenAI API to generate images based on given inputs.

## ✉️ Contact
For any inquiries or support, please contact us at brainycontactmail@gmail.com.
