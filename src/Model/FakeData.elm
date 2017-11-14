module Model.FakeData exposing (..)

import Dict exposing (Dict)

import Model.Resource exposing (..)

hardcodedResources : List Resource
hardcodedResources =
  [ Resource "Introduction to Machine Learning - Alex Smola" "http://alex.smola.org/drafts/thebook.pdf" "book" "" Dict.empty
  , Resource "A visual introduction to machine learning" "http://www.r2d3.us/visual-intro-to-machine-learning-part-1/" "article" "9 Aug 2015" Dict.empty
  , Resource "Friendly Introduction to Machine Learning - YouTube" "https://www.youtube.com/watch?v=IpGxLWOIZy4" "video" "9 Sep 2016" Dict.empty
  , Resource "Machine Learning Course | Udacity" "https://www.udacity.com/course/intro-to-machine-learning--ud120" "course" "" Dict.empty
  , Resource "An Introduction to Machine Learning | DigitalOcean" "https://www.digitalocean.com/community/.../an-introduction-to-machine-learning" "course" "28 Sep 2017" Dict.empty
  , Resource "Machine Learning is Fun! – Adam Geitgey – Medium" "https://medium.com/@ageitgey/machine-learning-is-fun-80ea3ec3c471" "article" "5 May 2014" Dict.empty
  , Resource "Introduction to Machine Learning" "https://ai.stanford.edu/~nilsson/mlbook.html" "book" "" Dict.empty
  , Resource "Introduction to Machine Learning - Online Course - DataCamp" "https://www.datacamp.com/courses/introduction-to-machine-learning-with-r" "course" "" Dict.empty
  , Resource "An Introduction to Machine Learning Algorithms - DataScience.com" "https://www.datascience.com/blog/introduction-to-machine-learning-algorithms" "article" "29 Jun 2017" Dict.empty
  , Resource "A Gentle Introduction to Machine Learning - The New Stack" "https://thenewstack.io/gentle-introduction-machine-learning/" "article" "14 Apr 2017" Dict.empty
  , Resource "An Introduction to Machine Learning Theory and Its Applications - Toptal" "https://www.toptal.com/machine-learning/machine-learning-theory-an-introductory-primer" "article" "" Dict.empty
  , Resource "Machine Learning | Coursera" "https://www.coursera.org/learn/machine-learning" "course" "" Dict.empty
  , Resource "Introduction To Machine Learning Courses | Coursera" "https://www.coursera.org/specializations/machine-learning" "course" "" (Dict.singleton "cost" "free trial")
  , Resource "Machine Learning Foundations: A Case Study Approach" "https://www.coursera.org/learn/ml-foundations" "course" "" (Dict.singleton "cost" "free trial")
  , Resource "Introduction to Machine Learning - SlideShare" "https://www.slideshare.net/rahuldausa/introduction-to-machine-learning-38791937" "presentation" "7 Sep 2014" Dict.empty
  , Resource "An introduction to machine learning today - Opensource.com" "https://opensource.com/article/17/9/introduction-machine-learning" "article" "20 Sep 2017" Dict.empty
  , Resource "Introduction To Machine Learning, Spring 2016 - people.csail.mit.edu" "https://people.csail.mit.edu/dsontag/courses/ml16/" "university course" "" Dict.empty
  , Resource "Introduction to Machine Learning for Developers - Algorithmia Blog" "https://blog.algorithmia.com/introduction-machine-learning-developers/" "article" "" Dict.empty
  , Resource "A Non-Technical Introduction to Machine Learning – SafeGraph" "https://blog.safegraph.com/a-non-technical-introduction-to-machine-learning-b49fce202ae8?gi=ccaf0749079" "article" "3 Mar 2017" Dict.empty
  , Resource "A Brief Introduction to Machine Learning for Engineers" "https://arxiv.org/abs/1709.02840" "book" "8 Sep 2017" Dict.empty
  , Resource "Intro To Machine Learning - Python & R In Data Science" "https://www.udemy.com/machinelearning" "course" "" Dict.empty
  , Resource "http://ocdevel.com/podcasts/machine-learning" "OCDevel" "podcast" "" Dict.empty ]
