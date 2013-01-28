=begin
Задачи:
1. Дана строка слов, разделёных пробелами. Вывести длиннейшее слово.
2. Дан текст. Найдите все URL адреса и вычлените из них ссылку на корневую страницу сайта (например, из http://rubygarage.org/course.html сделайте http://rubygarage.org).
3. Дан текст. Найдите наибольшее количество идущих подряд цифр в нем.
4. Дан текст. Необходимо подсчитать, сколько раз встречается каждое слово в тексте.
=end

some_text = <<some_text
But I must 1 explain to you 3444 how all http://www.ukr.net/news/politika.html this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great 444 explorer of the truth, the master-builder of 11134 human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know 0 how to pursue 334 pleasure rationally encounter consequences that are 111 extremely painful. Nor again 2 is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which 3444 toil and pain can procure him some great 234234 234 pleasure. http://www.teletrade.com.ua/novice/promo?utm_source=ukr&utm_medium=kak&utm_campaign=silki to take a trivial example, which of us ever undertakes laborious physical exercise, http://orakul.com/horoscope/astro/general/today/lion.html except to obtain 11 some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure 312 that has 777 no annoying consequences, or one who avoids a pain that produces no resultant pleasure?
some_text

def only_words(some_text)
  some_text.gsub(/http:[^\s+]+/,'').scan(/[a-zA-Z]+/)
end

def longest_words(words)
  words.group_by(&:length).max[1].uniq
end

def root_urls(some_text)
  some_text.scan(/http:\/\/[^\/]+/)
end

def longest_number(some_text)
  some_text.scan(/\d+/).sort_by(&:length).last
end

def words_stats(words)
  words.inject(Hash.new(0)) { |h, word| h[word.downcase] += 1 ; h }
end

words = only_words some_text

puts "1) longest words: #{longest_words(words).join(', ')}"
puts "2) root URLs: #{root_urls(some_text).join(', ')}"
puts "3) longest number: #{longest_number(some_text)}"
puts "4) words statistics: #{words_stats(words)}"
