import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["todoList", "addBtn"]

  connect() {
    this.loadTodos()
  }



  loadTodos() {
    const todos = JSON.parse(localStorage.getItem('todos')) || []
    this.todoListTarget.innerHTML = '' // 清除之前的 Todo 项
    todos.reverse().forEach(todo => {  // 反转顺序
      this.addTodoToList(todo.text, todo.completed)
    })
  }




  addTodo() {
    const todoText = prompt('Enter a new todo:')
    if (todoText) {
      this.addTodoToList(todoText, false)
      this.saveTodos()
    }
  }

  addTodoToList(text, completed) {
    const li = document.createElement('li')
    li.innerHTML = `
      <input type="checkbox" class="todo-checkbox" ${completed ? 'checked' : ''}>
      <span class="todo-text ${completed ? 'completed' : ''}">${text}</span>
      <button class="todo-delete-btn">X</button>
    `
    li.querySelector('.todo-checkbox').addEventListener('change', (e) => {
      e.target.nextElementSibling.classList.toggle('completed')
      this.saveTodos()
    })
    li.querySelector('.todo-delete-btn').addEventListener('click', () => {
      this.deleteTodo(li)
    })
    this.todoListTarget.insertAdjacentElement('afterbegin', li) // 添加到列表顶部
  }

  deleteTodo(todoItem) {
    this.todoListTarget.removeChild(todoItem)
    this.saveTodos()
  }

  saveTodos() {
    const todos = Array.from(this.todoListTarget.querySelectorAll('li')).map(li => ({
      text: li.querySelector('.todo-text').textContent,
      completed: li.querySelector('.todo-checkbox').checked
    }))
    localStorage.setItem('todos', JSON.stringify(todos))
  }
}
