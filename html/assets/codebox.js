
//-------------------------------------------------------------------------------------------------------------------------------------*/

// ╭∩╮     ╭∩╮
//  \(͡⚈ᴗ͡⚈)/

//-------------------------------------------------------------------------------------------------------------------------------------*/

document.addEventListener('DOMContentLoaded', () => {
  const codeBox = document.querySelector('.code-box');
  const pre = codeBox.querySelector('pre');
  const code = pre.querySelector('code');

  // Split the text content using a regex that handles all types of line breaks
  const lines = code.textContent.split(/\r\n|\r|\n/);
  const lineNumbers = document.createElement('div');
  lineNumbers.classList.add('line-numbers');

  lines.forEach((line, index) => {
    // Count logical lines based on the actual content of each line
    const logicalLines = countLogicalLines(line);
    for (let i = 0; i < logicalLines; i++) {
      const lineNumber = document.createElement('span');
      lineNumber.textContent = index + 1; // Line numbers start at 1
      lineNumbers.appendChild(lineNumber);
    }
  });

  codeBox.appendChild(lineNumbers);

  // Adjust the padding of the pre element to align with the line numbers
  pre.style.paddingLeft = `${lineNumbers.offsetWidth + 10}px`;
});

// Function to count logical lines within a given line of code
function countLogicalLines(line) {
  const lineHeight = 18; // Adjust based on your CSS line-height value
  const preWidth = 750; // Adjust based on your .code-box width in CSS

  // Calculate logical lines based on pre width and line height
  const maxCharactersPerLine = Math.floor(preWidth / (lineHeight / 2));
  return Math.ceil(line.length / maxCharactersPerLine) || 1;
}

