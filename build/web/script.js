const quotes = [
    "Zindagi ki gaadi aage badhani hai? First, rent the right one! 😎",
    "Petrol bharwana mat bhoolna, emotions pe chalne wali sirf Mohabbatein wali train thi! 🚂😂",
    "Steering in your hands, adventure in your heart – let’s roll!",
    "Apni nahi toh kya hua, ek din ke liye hi sahi, gaadi toh apni hogi! 🚘",
    "Book today, drive away – kyunki gaadi lene ka maza tabhi hai jab bina tension ke mile!"
];

let index = 0;
const quoteElement = document.getElementById("quote");

function changeQuote() {
    index = (index + 1) % quotes.length;
    quoteElement.style.opacity = 0; 
    setTimeout(() => {
        quoteElement.innerText = quotes[index];
        quoteElement.style.opacity = 1; 
    }, 500);
}

setInterval(changeQuote, 7000);
