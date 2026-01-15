using TasksApi.Models;

namespace TasksApi.Repositories;

public interface ITaskRepository
{
    IEnumerable<TaskItem> GetAll();
    TaskItem? GetById(Guid id);
    TaskItem Create(TaskItem item);
    bool Update(Guid id, TaskItem item);
    bool Delete(Guid id);
}
