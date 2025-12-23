from git import Repo

# Path to your repository
repo_path = r"C:\Users\HP\AWS_grocery"
repo = Repo(repo_path)

# Stage the Dockerfile (or any files you want)
repo.git.add("backend/Dockerfile")

# Commit the changes
repo.index.commit("Add backend Dockerfile")

# Push to your branch (replace 'version2' with your branch)
origin = repo.remote(name='origin')
origin.push('version2')

print("Dockerfile committed and pushed successfully!")
