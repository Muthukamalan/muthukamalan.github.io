---
title:  ""
layout: splash
permalink: /
hidden: true
header:
  # overlay_color: "#5e616c"
  overlay_image: "/../assets/images/profile.jpg"
  # overlay_filter: 0.2
  # overlay_text: 
  image: https://github.com/mmistakes/minimal-mistakes/blob/master/docs/assets/images/mm-home-page-feature.jpg?raw=true
  # actions:
  #   - label: "<i class='fas fa-contact'></i>About"
  #     url: "about"
  #     align: top
excerpt: >
  <div class="page__hero--bottom-left">
  <div class="social-icons">
    <a href="https://github.com/Muthukamalan" class="btn btn--x-large" target="_blank" rel="noopener noreferrer">
      <i class="fa-brands fa-github fa-2xl"></i>
    </a>

    <a href="https://www.linkedin.com/in/muthukamalan-m/" class="btn btn--x-large" target="_blank" rel="noopener noreferrer">
      <i class="fa-brands fa-linkedin fa-2xl"></i>
    </a>

    <a href="https://wa.me/9486872592" class="btn btn--x-large" target="_blank" rel="noopener noreferrer">
      <i class="fa-brands fa-whatsapp fa-2xl"></i>
    </a>
  </div>

  <p>
    <span style="color: #58485f;">Some days I patch bugs in the code, other days I patch feelings with a stanza.</span>
  </p>
  <p style="bottom: 0; right: 0; margin: 0;">
    <span style="color: #000000;">Blog crafted by 100% human</span>
  </p>
  </div>



list-posts:
  - image_path: /../assets/2026-07-27-git-in-practical/default-thumbnail.png
    alt: "fully responsive"
    title: "Git in Practical"
    excerpt: "Git is a free and open source distributed version control system"
    url: "/blog/git-in-practical/"
    btn_class: "btn--primary"
    btn_label: "Learn more"
  - image_path: /../assets/2026-07-27-know-kserve/default-thumbnail.png
    alt: "fully responsive"
    title: "Know Kserve"
    excerpt: "Distributed Generative and Predictive AI Inference Platform"
    url: "/blog/know-kserve"
    btn_class: "btn--primary"
    btn_label: "Learn more"
  - image_path: /../assets/2026-07-27-secrets-of-life/default-thumbnail.png
    alt: "fully responsive"
    title: "Things Keep Me Moving"
    excerpt: "Secrets of Life ( poem )"
    url: "/blog/secrets-of-life/"
    btn_class: "btn--primary"
    btn_label: "Learn more"
  - image_path: 
    title: 
    excerpt: 
    url: "/posts"
    btn_class: "btn--small"
    btn_label: "All Posts ->"
  


list-projects:
  - image_path: /../assets/project-mlops-churn/churn-prediction.png
    alt: "image1"
    title: "MLOps Churn Prediction"
    excerpt: "it forecast which users are likely to stop using a service. identifies early warning signs so businesses can take action to keep clients"
    url: "/projects/mlops-chrun-prediction"
    btn_class: "btn--primary"
    btn_label: "Learn more"

  - image_path: /../assets/project-media-2-ascii/media2ascii.png
    alt: "image2"
    title: "Ascii Art Python Package"
    excerpt: "ASCII is a character encoding standard used in computers and other devices to represent text"
    url: "/projects/media-2-ascii/"
    btn_class: "btn--primary"
    btn_label: "Learn more"
  
  - image_path: "/../assets/project-microservices-poc/default-thumbnail.png"
    alt: "image3"
    title: "Microservice in Reality"
    excerpt: "microservice are not a silver bullet it's a trade-off. Adopting a microservices trades the complexity of a single monolithic codebase for the immense operational complexity of a distributed system. So justify me?"
    url: "/projects/project-microservices-poc/"
    btn_class: "btn--primary"
    btn_label: "Learn more"
  - image_path: 
    title: 
    excerpt: 
    url: "/projects"
    btn_class: "btn--small"
    btn_label: "All Projects ->"

# self-intro:
#   - image_path: https://img.amiami.com/images/product/main/234/GOODS-04430263.jpg?raw=true
#     alt: "placeholder image 2"
#     title: ""
#     excerpt: 'collection of my personal experiences, thoughts, and little moments that"ve shaped my journey.'
#     url: "about"
#     btn_label: "Read More"
#     btn_class: "btn--small"


---

<h2 align="center">Featured Projects</h2>
{% include feature_row id="list-projects"  %}



<h2 align="center">Featured Posts</h2>
{% include feature_row id="list-posts"  %}


<!-- {% include feature_row id="feature_row" type="left" %} -->

<!-- {% include feature_row id="self-intro" type="center" %} -->


