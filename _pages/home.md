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
    <large><a href="https://github.com/Muthukamalan" class="btn btn--x-large tn-blue"><i class="fa-brands fa-github fa-2xl"></i></a></large>
    <large><a href="https://www.linkedin.com/in/muthukamalan-m/" class="btn btn--x-large tn-blue"><i class="fa-brands fa-linkedin fa-2xl"></i></a></large>
    <large><a href="https://wa.me/9486872592" class="btn btn--x-large tn-blue"><i class="fa-brands fa-whatsapp fa-2xl"></i></a></large>
    
    Some days I patch bugs in the code, other days I patch feelings with a stanza<br/>
  </div>




list-posts:
  - image_path: /../assets/2026-07-27-git-in-practical/default-thumbnail.png
    alt: "fully responsive"
    title: "Featured Blogs"
    excerpt: "Lorem poresum"
    url: "/posts"
    btn_class: "btn--primary"
    btn_label: "Learn more"
  - image_path: /../assets/2026-07-27-know-kserve/default-thumbnail.png
    alt: "fully responsive"
    title: "Featured Blogs"
    excerpt: "Lorem poresum"
    url: "/posts"
    btn_class: "btn--primary"
    btn_label: "Learn more"
  - image_path: /../assets/2026-07-27-secrets-of-life/default-thumbnail.png
    alt: "fully responsive"
    title: "Featured Blogs"
    excerpt: "Lorem poresum"
    url: "/posts"
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
    excerpt: "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
    url: "/projects/mlops-churn/mlops-chrun-prediction/"
    btn_class: "btn--primary"
    btn_label: "Learn more"

  - image_path: /../assets/project-media-2-ascii/default-thumbnail.png
    alt: "image2"
    title: "Python Package"
    excerpt: "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
    url: "/projects/py-pkg/media-2-ascii/"
    btn_class: "btn--primary"
    btn_label: "Learn more"
  
  - image_path: "/../assets/project-kserve/Istio.png"
    alt: "image3"
    title: "Featured Project"
    excerpt: "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
    url: ""
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


