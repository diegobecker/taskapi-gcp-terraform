using TasksApi.Repositories;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Health
builder.Services.AddHealthChecks();

// DI do repositório em memória
builder.Services.AddSingleton<ITaskRepository, InMemoryTaskRepository>();

var app = builder.Build();

// Swagger ligado (pra estudo)
app.UseSwagger();
app.UseSwaggerUI();

// app.UseHttpsRedirection();

app.MapHealthChecks("/health");
app.MapControllers();

// Cloud Run padrão
// app.Urls.Add("http://0.0.0.0:8080");

app.Run();
