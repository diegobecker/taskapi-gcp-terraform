using System.Collections.Concurrent;
using TasksApi.Models;

namespace TasksApi.Repositories;

public class InMemoryTaskRepository : ITaskRepository
{
    private readonly ConcurrentDictionary<Guid, TaskItem> _store = new();

    public IEnumerable<TaskItem> GetAll()
        => _store.Values.OrderBy(x => x.Title);

    public TaskItem? GetById(Guid id)
        => _store.TryGetValue(id, out var item) ? item : null;

    public TaskItem Create(TaskItem item)
    {
        item.Id = item.Id == Guid.Empty ? Guid.NewGuid() : item.Id;
        _store[item.Id] = item;
        return item;
    }

    public bool Update(Guid id, TaskItem item)
    {
        if (!_store.ContainsKey(id)) return false;
        item.Id = id;
        _store[id] = item;
        return true;
    }

    public bool Delete(Guid id)
        => _store.TryRemove(id, out _);
}
