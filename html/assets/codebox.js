
//-------------------------------------------------------------------------------------------------------------------------------------*/

// ╭∩╮     ╭∩╮
//  \(͡⚈ᴗ͡⚈)/

//-------------------------------------------------------------------------------------------------------------------------------------*/

document.addEventListener('DOMContentLoaded', () => {
  const codeBox = document.querySelector('.code-box');
  const pre = codeBox.querySelector('pre');
  const code = pre.querySelector('code');

  const lines = code.textContent.trim().split('\n');
  const lineNumbers = document.createElement('div');
  lineNumbers.classList.add('line-numbers');

  lines.forEach((line, index) => {
    const lineNumber = document.createElement('span');
    lineNumber.textContent = index + 1;
    lineNumbers.appendChild(lineNumber);
  });

  codeBox.appendChild(lineNumbers);

  pre.style.paddingLeft = `${lineNumbers.offsetWidth + 10}px`;
});
